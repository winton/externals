Externals
=========

Quickly freeze and unfreeze external git dependencies.

Installation
------------

<pre>
sudo gem install winton-externals
</pre>

Configuration
-------------

Create *config/externals.yml*:

<pre>
pa_stats:
  repo: git@github.com:br/pa_stats.git
  path: vendor/gems
</pre>

Freeze or unfreeze
------------------

You can run either of these for the first time, depending on what you want:

<pre>
externals freeze
externals unfreeze
</pre>

The usual flow is to unfreeze, commit to the external, freeze, and commit to the parent project.

Your .git directories will be zipped and stored in /tmp when frozen, and moved back to the external when unfrozen.