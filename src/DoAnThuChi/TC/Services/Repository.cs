using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using TC.Services.Context;

namespace TC.Services
{
    public interface IRepository<TEntity> where TEntity : class
    {
        TEntity GetById(int id);
        IEnumerable<TEntity> GetAll();
        void Upsert(TEntity entity);
        void Remove(TEntity entity);
        IQueryable<TEntity> Filter();
    }
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        protected readonly TCDbContext _dbContext;
        protected readonly DbSet<TEntity> _dbSet;

        public Repository(TCDbContext dbContext)
        {
            _dbContext = dbContext;
            _dbSet = _dbContext.Set<TEntity>();
        }

        public IEnumerable<TEntity> GetAll()
        {
            return _dbSet.ToList();
        }

        public IQueryable<TEntity> Filter()
        {
            return _dbSet.AsQueryable();
        }

        public TEntity GetById(int id)
        {
            // Có thể cần tùy chỉnh cho các Entity không có khóa tên là 'Id'
            return _dbSet.Find(id);
        }

        public void Upsert(TEntity entity)
        {
            _dbSet.AddOrUpdate(entity);
        }

        public void Remove(TEntity entity)
        {
            _dbSet.Remove(entity);
        }
    }
}