namespace $rootnamespace$.Helpers
{
    internal class SpecificationController<T>
    {
        private readonly AutoMockingContainer _amc;
        public SpecificationController()
        {
            _amc = new AutoMockingContainer();
        }

        public T Subject
        {
            get
            {
                var result = _amc.Resolve<T>();
                return result;
            }
            set
            {
                _amc.RegisterInstance(value);
            }
        }

        public void With<TDependency>(TDependency dependency)
        {
            _amc.RegisterInstance(dependency);
        }

        public TDependency The<TDependency>() where TDependency: class
        {
            return _amc.Resolve<TDependency>();
        }
    }
}