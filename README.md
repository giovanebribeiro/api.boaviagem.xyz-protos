# api.boaviagem.xyz-protos

Contém os arquivos [proto](https://developers.google.com/protocol-buffers/docs/proto) para comunicação entre os serviços da minha API.

Este projeto possui deploy automático por meio do Github Actions, e no momento, estes arquivos geram bibliotecas para comunicação por meio do protocolo gRPC nas seguintes linguagens:

* [C#](https://github.com/giovanebribeiro/api.boaviagem.xyz-contracts/packages/991213)
* [Javascript (Node.js)]()

## Geração dos arquivos para compilação

Para a geração dos arquivos para algumas linguagens é necessário o [compilador](https://grpc.io/docs/protoc-installation/) para arquivos protobuf.