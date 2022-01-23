---
title: "Pattern: Expor versão não genérica de interfaces genéricas"
date: 2021-12-24T01:52:00-00:00
comments: true
tags:
  - OpenSource
  - GitHub
  - C#
  - SOLID
  - Patterns
---

Se você está familiarizado com o ambiente .NET, com certeza já ouviu falar da interface `IEnumerable<T>` utilizada para iterar listas em instruções `foreach`, porém antes do namespace `System.Collections.Generic` ser criado, existia apenas o `IEnumerable`(não genérico) do namespace `System.Collections`. 

Hoje, `IEnumerable<T>` estende de `IEnumerable`:
```csharp
namespace System.Collections
{
    public interface IEnumerable
    {
        IEnumerator GetEnumerator();
    }
}

namespace System.Collections.Generic
{
    public interface IEnumerable<out T> : IEnumerable
    {
        new IEnumerator<T> GetEnumerator();
    }
}
```
## Veja as vantagens de implementar esse padrão:
- Essa herança faz sentido para não quebrar códigos legado e permite mais generalidade, fornecendo uma implementação não genérica para os consumidores.
- Durante o uso do operador `is`, não é necessário informar o tipo do genérico.

Exemplo:
```csharp
object validator = new ValidatorImpl();

if (validator is Validator<int>) /** Precisa informar o tipo **/
{

}
else if (validator is Validator) /** Não precisa informar o tipo **/
{

}
```

Fontes: <br>
https://stackoverflow.com/questions/9197465/ <br>
https://stackoverflow.com/questions/6623188/ <br>
https://gamedev.stackexchange.com/questions/145037/ <br>
https://stackoverflow.com/questions/16112353/ <br>
https://whatheco.de/2015/12/15/non-generic-wrapper-instead-of-base-class-or-interface/ <br>
https://whatheco.de/2011/07/02/casting-to-less-generic-types/ <br>