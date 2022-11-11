---
title: "Compute shaders: calculando na GPU."
date: 2022-11-11T01:21:00-00:00
comments: true
tags:
  - HLSL
  - C#
  - Unity
---

Não vou entrar em detalhes sobre a linguagem [HLSL](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl) (High-level shader language), talvez outro dia eu escreva mais sobre ele aqui, mas vou citar abaixo alguns pontos importante que (provavelmente) vou esquecer quando criar um arquivo *.compute lá em 2050.

# "0 é int, 0.0 é float"

Básicão né? mas fiquei 10 minutos tentando entender porque meus cálculos não funcionavam.<br>
**A GPU não realiza uma conversão implícita em uma subtração com float e inteiro.**

```c
int num = 5;

float result = 1.0 / (num - 1.0); // resultado = 0.25 (float)
float result = float(1) / (num - float(1)); // resultado = 0.25 (float)
float result = (float) 1 / (num - (float) 1); // resultado = 0.25 (float)

float result = 1 / (num - 1); // resultado = 0 (float)
```

# Arrays não podem ter dimensões definidas através de variáveis.

### [ERR_ARRAY_LITERAL: Array dimensions must be literal scalar expressions.](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/hlsl-errors-and-warnings)

Não conseguimos definir a `length` do array através de variáveis, precisa ser uma expressão literal pro shader ser compilado(e com otimizações):

![](2022-11-11-01-36-58.png)

```c
float seu_array[30]; // OK!

float seu_array[size_array]; // ERRO!
```

Links úteis:
- https://stackoverflow.com/a/40957587
- https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-variable-syntax?redirectedfrom=MSDN

# Por precaução, sempre inicializar arrays se lidas posteriormente...

![](2022-11-11-01-45-06.png)

```c
RWStructuredBuffer<float> data;

#pragma kernel ComputeData
[numthreads(256, 1, 1)] void ComputeData(int index: SV_DispatchThreadID) {
    float terraces[30];

    for (int x = 0; x < 30; x++) { // Se remover este loop, o error acima é acionado.
        terraces[x] = 0.0;
    }

    if (index.x < 30) {
        data[index.x] = terraces[index.x];
    }
}
```