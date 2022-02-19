---
title: "Design Patterns em projetos"
date: 2022-01-04T21:36:00-00:00
comments: true
draft: true
tags:
  - C#
  - Patterns
  - DesignPatterns
---

O objetivo deste post é mostrar exemplos de Design Patterns em projetos famosos que estão espalhados pelo GitHub.

## Factory

- Projeto: [CacheManager](https://github.com/MichaCo/CacheManager/) <br>
- Padrão de projeto criacional **Factory**: `CacheFactory` instância a classe `BaseCacheManager` sem expor a lógica de criação.

<b>[src\CacheManager.Core\CacheFactory.cs](https://github.com/MichaCo/CacheManager/blob/dev/src/CacheManager.Core/CacheFactory.cs)</b>
```csharp
public abstract class BaseCache<TCacheValue> : IDisposable, ICache<TCacheValue> { }

public partial class BaseCacheManager<TCacheValue> : BaseCache<TCacheValue>, ICacheManager<TCacheValue>, IDisposable { }

public static class CacheFactory
{
    public static ICacheManager<object> Build(/** ... **/) => Build<object>(/** ... **/);

    public static ICacheManager<TCacheValue> Build<TCacheValue>(/** ... **/)
    {
        /** ... **/
        return new BaseCacheManager<TCacheValue>(/** ... **/);
    }

    public static object FromConfiguration(/** ... **/) => FromConfiguration<object>(/** ... **/);

    public static ICacheManager<TCacheValue> FromConfiguration<TCacheValue>(/** ... **/)
    {
        /** ... **/
        return new BaseCacheManager<TCacheValue>(/** ... **/);
    }
}
```

Exemplo:
```csharp
using System;
using CacheManager.Core;

namespace ConsoleApplication;

var cache = CacheFactory.Build("getStartedCache", settings =>
{
    settings.WithSystemRuntimeCacheHandle("handleName");
});
```

## Observações:
- <span style="color:#8bc34a;">A classe foi marcada como `static` para que seu único objetivo seja criar um novo `CacheManager`.</span>
- <span style="color:#8bc34a;">A classe sempre retorna uma interface para evitar o alto acoplamento.</span>
- <span style="color:#8bc34a;">É possível gerar um `CacheManager` de duas maneiras: a partir de uma configuração pré-existente ou criando um novo.</span>
- <span style="color:#ff7a8c;">`BaseCacheManager` é marcado como `partial`, o que torna ela aberta para modificações, <b>[ferindo o princípio do open-closed](http://www.fascinatedwithsoftware.com/blog/post/2012/06/17/Partial-Classes-as-Design-Elements.aspx)</b>.  </span>


## Fluent Interface

- Projeto: [FluentValidation](https://github.com/FluentValidation/FluentValidation) <br>
- Padrão de projeto criacional **Fluent Interface**: 

<b>[src/FluentValidation/DefaultValidatorExtensions.cs](https://github.com/FluentValidation/FluentValidation/blob/main/src/FluentValidation/DefaultValidatorExtensions.cs)</b>
```csharp

public static partial class DefaultValidatorExtensions {
    /* ... */

    public static IRuleBuilderOptions<T, TProperty> NotNull<T, TProperty>(this IRuleBuilder<T, TProperty> ruleBuilder) {
        return ruleBuilder.SetValidator(new NotNullValidator<T,TProperty>());
    }

    public static IRuleBuilderOptions<T, TProperty> Null<T, TProperty>(this IRuleBuilder<T, TProperty> ruleBuilder) {
        return ruleBuilder.SetValidator(new NullValidator<T,TProperty>());
    }

    public static IRuleBuilderOptions<T, TProperty> NotEmpty<T, TProperty>(this IRuleBuilder<T, TProperty> ruleBuilder) {
        return ruleBuilder.SetValidator(new NotEmptyValidator<T,TProperty>());
    }

    /* ... */
}
```

<b>[src/FluentValidation/Internal/RuleBuilder.cs](https://github.com/FluentValidation/FluentValidation/blob/main/src/FluentValidation/Internal/RuleBuilder.cs)</b>
```csharp
public abstract class AbstractValidator<T> : IValidator<T>, IEnumerable<IValidationRule> {

    public IRuleBuilderInitial<T, TProperty> RuleFor<TProperty>(/* ... */) {
        /* ... */
        return new RuleBuilder<T, TProperty>(/* ... */);
    }

}
```

## Observações:
- <span style="color:#8bc34a;">O .</span>