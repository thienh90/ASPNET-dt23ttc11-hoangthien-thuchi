
using System;
using System.Collections.Concurrent;
using System.Web;

namespace TC.Services
{

    public enum Lifetime
    {
        Singleton,
        Transient,
        Scoped
    }

    public class ServiceDescriptor
    {
        public Lifetime Lifetime { get; }
        public Func<object> Factory { get; }
        public object SingletonInstance { get; set; }

        public ServiceDescriptor(Lifetime lifetime, Func<object> factory)
        {
            Lifetime = lifetime;
            Factory = factory;
        }
    }

    public static class ServiceLocator
    {
        private static readonly ConcurrentDictionary<Type, ServiceDescriptor> _services = new ConcurrentDictionary<Type, ServiceDescriptor>();
        private const string ScopedContextKey = "ServiceLocator_ScopedInstances";

        // Đăng ký Singleton
        public static void RegisterSingleton<TService, TImplementation>()
            where TService : class
            where TImplementation : TService, new()
        {
            var descriptor = new ServiceDescriptor(Lifetime.Singleton, () => new TImplementation());
            descriptor.SingletonInstance = descriptor.Factory(); // Khởi tạo ngay lập tức
            _services[typeof(TService)] = descriptor;
        }

        // Đăng ký Transient
        public static void RegisterTransient<TService, TImplementation>()
            where TService : class
            where TImplementation : TService, new()
        {
            var descriptor = new ServiceDescriptor(Lifetime.Transient, () => new TImplementation());
            _services[typeof(TService)] = descriptor;
        }

        // Đăng ký Scoped
        public static void RegisterScoped<TService, TImplementation>()
            where TService : class
            where TImplementation : TService, new()
        {
            var descriptor = new ServiceDescriptor(Lifetime.Scoped, () => new TImplementation());
            _services[typeof(TService)] = descriptor;
        }

        // Phương thức lấy dịch vụ
        public static TService GetService<TService>()
            where TService : class
        {
            var serviceType = typeof(TService);
            if (!_services.TryGetValue(serviceType, out var descriptor))
            {
                throw new InvalidOperationException($"Không tìm thấy dịch vụ cho kiểu {serviceType.FullName}");
            }

            switch (descriptor.Lifetime)
            {
                case Lifetime.Singleton:
                    return (TService)descriptor.SingletonInstance;

                case Lifetime.Scoped:
                    var httpContext = HttpContext.Current;
                    if (httpContext == null)
                    {
                        // Trường hợp ngoại lệ: không có HttpContext, có thể là unit test
                        // Hoặc trả về Transient
                        return (TService)descriptor.Factory();
                    }

                    var scopedInstances = httpContext.Items[ScopedContextKey] as ConcurrentDictionary<Type, object>;
                    if (scopedInstances == null)
                    {
                        scopedInstances = new ConcurrentDictionary<Type, object>();
                        httpContext.Items[ScopedContextKey] = scopedInstances;
                    }

                    return (TService)scopedInstances.GetOrAdd(serviceType, _ => descriptor.Factory());

                case Lifetime.Transient:
                    return (TService)descriptor.Factory();
            }

            throw new InvalidOperationException("Loại Lifetime không hợp lệ.");
        }
    }
}