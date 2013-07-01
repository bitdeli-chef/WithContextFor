using System;
using System.Collections.Generic;
using System.Linq;
using NSubstitute;

namespace $rootnamespace$.Helpers
{
    internal class AutoMockingContainer
    {
        readonly IDictionary<Type, object> _instances = new Dictionary<Type, object>();

        public void RegisterInstance<T>(T instance)
        {
            RegisterInstance(typeof(T), instance);
        }

        private void RegisterInstance(Type type, object instance)
        {
            _instances[type] = instance;
        }

        public T Resolve<T>()
        {
            return (T)Resolve(typeof(T));
        }

        private object Resolve(Type type)
        {
            if (_instances.ContainsKey(type))
                return _instances[type];

            object o = Instantiate(type);
            RegisterInstance(type, o);
            return o;
        }

        public object Instantiate(Type type)
        {
            if (type.IsInterface)
                return Substitute.For(new[] { type }, new object[0]);

            var constructorInfo = type.GetConstructors().OrderByDescending(x => x.GetParameters().Length).First();

            var constructorParameters = constructorInfo.GetParameters();
            var args = new List<object>();
            foreach (var parameterInfo in constructorParameters)
            {
                args.Add(Resolve(parameterInfo.ParameterType));
            }

            return constructorInfo.Invoke(args.ToArray());
        }
    }
}