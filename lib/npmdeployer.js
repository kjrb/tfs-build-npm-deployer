var path = require('path');
var tl = require('vso-task-lib');

var msg = tl.getInput('msg', false);
var cwd = tl.getInput('cwd', false);
var packageSource = tl.getInput('packageSource', false);

tl.debug("Entering script $MyInvocation.MyCommand.Name"); 
tl.debug("msg = " + msg); 
tl.debug("cwd = " + cwd);
tl.debug("packageSource = " + packageSource);

var npm = new tl.ToolRunner(tl.which('npm', true));

tl.debug('using npm: ' + npm);

var npmDeployerGitTaggerPackageName = "npm-deployer-git-tagger"

npm.arg('install');

if (packageSource) {
	npm.arg(packageSource);
}
else {
	npm.arg(npmDeployerGitTaggerPackageName);
}

if (cwd) {
	tl.cd(cwd);
}

npm.exec()
	.then(function (code) {
		tl.exit(code);
		tl.debug('all good need to run the next command');

		var npmArgsNpmDeployer = " ./node_modules/" + npmDeployerGitTaggerPackageName + "/index.js"
		tl.debug("Will run $npmArgsNpmDeployer");

		var node = new tl.ToolRunner(tl.which('node', true)); 
		node.arg(npmArgsNpmDeployer);

		tl.debug('using node: ' + node);

		node.exec()
			.then(function (code) {
				tl.exit(code);
				tl.debug('all done');
			}).
			fail(function (err) {
				tl.debug('taskRunner fail');
				tl.exit(1);
			})
	})
	.fail(function (err) {
		tl.debug('taskRunner fail');
		tl.exit(1);
	})

