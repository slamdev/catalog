const path = require('path');
const fs = require('fs');
const util = require('util');
const exec = util.promisify(require('child_process').exec);

class ProtoWebpackPlugin {

    constructor(options) {
        this.options = options;
    }

    apply(compiler) {
        compiler.hooks.done.tapPromise('ProtoWebpackPlugin', () => {
            console.log("Starting protoc generation");
            return Promise.all(this.createProtocPromises())
                .then(() => console.log("Finishing protoc generation"));
        });
    }

    createProtocPromises() {
        const protoDir = this.options.protoDir;
        const outputDir = this.options.outputDir;
        return this.getProtoFiles()
            .map(f => this.generateCode(protoDir, f, outputDir));
    }

    getProtoFiles() {
        const dir = this.options.protoDir;
        return this.readDir(dir)
            .filter(f => f.endsWith('.proto'))
            .map(f => path.relative(dir, f));
    }

    readDir(dir) {
        if (!fs.statSync(dir).isDirectory()) {
            return dir;
        }
        return Array.prototype.concat(...fs.readdirSync(dir)
            .map(f => path.join(dir, f))
            .map(f => this.readDir(f)));
    }

    generateCode(dir, file, output) {
        if (this.isFileGenerated(file, output)) {
            return Promise.resolve();
        }
        this.createDirIfNotExists(output);
        const command = ` \
        protoc -I=${dir} ${file} \
          --js_out=import_style=commonjs:${output} \
          --grpc-web_out=import_style=commonjs,mode=grpcwebtext:${output}`;
        return exec(command);
    }

    isFileGenerated(file, output) {
        const generatedFile = output + "/" + file.replace('.proto', '_pb.js');
        return fs.existsSync(generatedFile);
    }

    createDirIfNotExists(dir) {
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir);
        }
    }
}

module.exports = ProtoWebpackPlugin;
