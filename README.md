WithContextFor
==============

<sup>aka. Csudafrémvörk</sup>

Superlightweight automocking context for MSpec with NSubstitute, inspired by Machine.Fakes

## Installation

    Install-Package WithContextFor

## Usage

Use it as base class for you specification
```C#
    class MyService
    {
        public MyService(IMyDependency dependency, IAnotherDependency anotherDependency)
        {
            ...
        }

        public ServiceResult DoSomething()
        {
            ...
        }
    }

    [Subject(typeof(MyService))]
    class when_doing_something_interesting : WithContextFor<MyService, ServiceResult>
    {
        Establish context = () =>
            {
                The<IMyDependency>().SomeMethodCall()
                    .Returns(An<ISomething>());
                With(new StubAnotherDependency());
            };

        Because of = () =>
            Result = Subject.DoSomething();

        It should_not_be_null = () =>
            Result.ShouldNotBeNull();
    }
```
# The&lt;T>()

Creates an object with NSubstitute and attaches it to the automocking container. When the class under test is accessed through the Subject property, this object will be used when resolving the dependencies.

# A&lt;T>(), An&lt;T>()

Returns an object created by NSubstitute. Syntactic sugar over Substitute.For&lt;T>().

# With&lt;T>(T impl)

Registers an existing object to the automocking container

# Subject property

Use this property to instantiate the class under test using the automocking container.
