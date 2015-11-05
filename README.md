# tfs-build-npm-deployer

> tfs-build-npm-deployer contains **TFS 2015 Custom Build Step**.
It can be used in windows and cross platform build agent.
The purpose of the step is to check if a npm module version in the commit is greater than last published version
and if that is true the npm module will get published and git source will get tagged with the same version number.

## Dependencies

> [npm-deployer-git-tagger](https://github.com/kjrb/npm-deployer-git-tagger)

# How to install

If you haven't done so yet:
* [install TFS Extensions Command Line Utility: npm install -g tfx-cli](https://www.npmjs.com/package/tfx-cli)
* [clone this source from git](https://github.com/kjrb/tfs-build-npm-deployer)

Then execute:_~$ tfx build tasks upload ./lib from a root folder of the cloned repo_ 

Navigate to TFS and you should see npm deployer and git tagger in available build steps.

### You should be able to use it now in your builds.

[Read more] (http://sim4all.com/blogging/?p=520)
