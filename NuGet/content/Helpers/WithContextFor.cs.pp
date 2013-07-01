using NSubstitute;

namespace $rootnamespace$.Helpers
{
    public class WithContextFor<TSubject> where TSubject : class
    {
        private static SpecificationController<TSubject> _specificationController;

        protected WithContextFor()
        {
            _specificationController = new SpecificationController<TSubject>();
        }

        protected static TSubject Subject
        {
            get { return _specificationController.Subject; }
            set { _specificationController.Subject = value; }
        }

        protected static void With<TDependency>(TDependency implementation)
        {
            _specificationController.With(implementation);
        }

        protected static TDependency The<TDependency>() where TDependency : class
        {
            return _specificationController.The<TDependency>();
        }

        protected static TService An<TService>() where TService : class
        {
            return Substitute.For<TService>();
        }

        protected static TService A<TService>() where TService : class
        {
            return Substitute.For<TService>();
        }
    }

    public class WithContextFor<TSubject, TResult> : WithContextFor<TSubject>
        where TSubject : class
    {
        protected static TResult Result;

        public WithContextFor()
        {
            Result = default(TResult);
        }
    }
}