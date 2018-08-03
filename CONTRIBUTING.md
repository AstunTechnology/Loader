# Contributing to Loader

We welcome contributions to Loader, in the form of issues, bug fixes, or
suggestions for enhancements. This document sets out our guidelines and best
practices for such contributions.

It's based on the [Contributing to Open Source Projects
Guide](https://contribution-guide-org.readthedocs.io/).


## Submitting bugs

### Due diligence

Before submitting a bug, please do the following:

* Perform __basic troubleshooting__ steps:

    * __Make sure you're on the latest version.__ If you're not on the most
      recent version, your problem may have been solved already! Upgrading is
      always the best first step. You should be able to tell which version you
      have by comparing the copy of CHANGELOG.md in your version with the
      [latest on GitHub](https://github.com/AstunTechnology/Loader/blob/master/CHANGELOG.md).
    * [__Search the issue
      tracker__](https://github.com/AstunTechnology/Loader/issues?utf8=%E2%9C%93&q=is%3Aissue)
      to make sure it's not a known issue. If you
      don't find a pre-existing issue, consider [**checking the
      wiki**](https://github.com/AstunTechnology/Loader/wiki) in case the
      problem is non-bug-related.

### What to put in your bug report

Make sure your report gets the attention it deserves: bug reports with missing
information may be ignored or punted back to you, delaying a fix.  The below
constitutes a bare minimum; more info is almost always better:

* __What version of Python are you using?__ For example, are you using Python
  2.7.3, Python 3.3.1, PyPy 2.0?
* __What operating system are you using?__ Windows (7, 8, 32-bit, 64-bit,),
  Mac OS X,  (10.7.4, 10.9.0), Linux (which distribution, which version?)
  Again, more detail is better.
* __Which version or versions of the software are you using?__ Ideally, you've
  followed the advice above and are on the latest version, but please confirm
  this. 
* __How can the we recreate your problem?__ Imagine that we have never used
  Loader before and have downloaded it for the first time. Exactly what steps
  do we need to take to reproduce your problem?
    * If possible or appropriate, pare down your problem until the simplest
      case remains where your problem can be seen. Not only can indicate that
      the problem is not a bug, it will help us fix the bug more quickly.


## Contributing changes

### Contributor License Agreement

Your contribution will be under our [license](https://raw.githubusercontent.com/AstunTechnology/Loader/master/LICENSE.txt) as per [GitHub's terms of service](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license).

### Version control branching

* Always __make a new branch__ for your work, no matter how small. This makes
  it easy for others to take just that one set of changes from your repository,
  in case you have multiple unrelated changes floating around.

    * __Don't submit unrelated changes in the same branch/pull request!__ If it
      is not possible to review your changes quickly and easily, we may reject
      your request.

* __Base your new branch off of the appropriate branch__ on the main repository:

    * In general the released version of Loader is based on the ``master``
      (default) branch whereas development work is done under other non-default
      branches. Unless you are sure that your issue affects a non-default
      branch, __base your branch off the ``master`` one__.

* Note that depending on how long it takes for the dev team to merge your
  patch, the copy of ``master`` you worked off of may get out of date! 
    * If you find yourself 'bumping' a pull request that's been sidelined for a
      while, __make sure you rebase or merge to latest ``master``__ to ensure a
        speedier resolution.

### Code formatting

* __Please follow the coding conventions and style used in the Loader repository.__ 
* Loader endeavours to follow the
  [PEP-8](http://www.python.org/dev/peps/pep-0008/) guidelines but we don't
  mind longer lines ('E501 line too long' can normally be ignored).

### Documentation isn't optional

Pull requests without adequate documentation will be rejected. By
"documentation" we mean:

* New features should ideally include updates to __prose documentation__,
  including useful in-code comments and examples in the wiki.
* All submissions should have a __changelog entry__ crediting the contributor
  and/or any individuals instrumental in identifying the problem.

## Suggesting Enhancements

We welcome suggestions for enhancements, but reserve the right to reject them
if they do not follow future plans for Loader. 
