#!/usr/bin/env node

const { execSync } = require("child_process");
const Path = require("path");

console.log(__filename);

var parent = Path.dirname(Path.dirname(Path.dirname(__filename)));

console.log(parent);

const stdout = execSync(`grpc_tools_node_protoc --js_out=import_style=commonjs,binary:. --proto_path ${parent}/src --grpc_out=generate_package_definition:. ${parent}/src/echo.proto`);
console.log(`STDOUT = ${JSON.stringify(stdout)}`);
