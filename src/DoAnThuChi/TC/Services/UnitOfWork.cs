using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TC.Services.Context;

namespace TC.Services
{
    public interface IUnitOfWork : IDisposable
    {
        // Phương thức chung để lấy Repository cho một Entity bất kỳ
        IRepository<TEntity> Repository<TEntity>() where TEntity : class;
        void Commit();
    }
    public class UnitOfWork : IUnitOfWork
    {
        private readonly TCDbContext _dbContext;
        private readonly ConcurrentDictionary<Type, object> _repositories;

        public UnitOfWork()
        {
            _dbContext = ServiceLocator.GetService<TCDbContext>();
            _repositories = new ConcurrentDictionary<Type, object>();
        }

        public IRepository<TEntity> Repository<TEntity>() where TEntity : class
        {
            var type = typeof(TEntity);
            if (!_repositories.ContainsKey(type))
            {
                var repository = new Repository<TEntity>(_dbContext);
                _repositories.TryAdd(type, repository);
            }
            return (IRepository<TEntity>)_repositories[type];
        }

        public void Commit()
        {
            _dbContext.SaveChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _dbContext.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}