Externals
=========

Quickly freeze and unfreeze external git dependencies.

Compatibility
-------------

Tested with Ruby 1.8.6, 1.8.7, and 1.9.1.

Installation
------------

<pre>
gem install externals
</pre>

Configuration
-------------

Create *config/externals.yml*:

<pre>
acts_as_archive:
  repo: git://github.com/winton/acts_as_archive.git
  path: vendor/plugins
rails:
  repo: git://github.com/rails/rails.git
  path: vendor
</pre>

Freeze or unfreeze
------------------

You can run either of these for the first time, depending on what you want:

<pre>
externals freeze
externals unfreeze
</pre>

If you only want to freeze one of the items in config/externals.yml

<pre>
externals freeze acts_as_archive
externals unfreeze acts_as_archive
</pre>

The usual flow is to unfreeze, commit to the external, freeze, and commit to the parent project.

Your .git directories will be zipped and stored in /tmp when frozen, and moved back to the external when unfrozen.

Are my externals frozen?
------------------------

When you want to know the status of your externals:

<pre>
externals status
</pre>
