---
title: "Microsoft Entra ID (Azure AD): Fluxo Authorization Code"
date: 2023-08-09T00:00:00-00:00
comments: true
draft: true
tags:
  - Azure
  - AzureAD
  - OAuth2
  - OIDC
---

# PKCE (Proof Key for Code Exchange)


PKCE é uma extensão do OAuth que adiciona uma segurança extra ao fluxo de Authorization Code. Essa segurança ajuda a previnir o ataque de interceptação do código de autorização.

No código de exemplo abaixo estamos utilizando essa 



```html
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <title>Fluxo - Authorization Code</title>
    </head>
    <body class="p-5 flex justify-center">
        <button class="px-5 py-2 h-10 font-semibold text-sm bg-sky-500 text-white" onclick="auth()">
            Microsoft
        </button>
        <script type="text/javascript">
            const toBase64UrlEncoding = (str) => str.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '');

            function auth() {
                const codeVerifier = toBase64UrlEncoding(
                    CryptoJS.lib.WordArray.random(32).toString(CryptoJS.enc.Base64));
                const codeChallenge = toBase64UrlEncoding(
                    CryptoJS.SHA256(codeVerifier).toString(CryptoJS.enc.Base64));

                localStorage.setItem('codeVerifier', codeVerifier);

                const url =
                    'https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/authorize?' +
                        'client_id=<CLIENT_ID>'+
                        '&response_type=code' +
                        '&response_mode=query' +
                        '&redirect_uri=' + encodeURIComponent('<REDIRECT_URI>') +
                        '&scope=' + encodeURIComponent('<SCOPES>') +
                        '&code_challenge=' + codeChallenge +
                        '&code_challenge_method=S256';

                window.location.href = url;
            }
        </script>
    </body>
</html>
```