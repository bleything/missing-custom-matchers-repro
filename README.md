Missing Custom Matchers Bug Reproduction
================================================================================

I've been encountering difficulties with [chefspec] where sometimes it seems to
not be able to find my custom matchers. According to its documentation, it
should automatically load `libraries/matchers.rb` when it's required, but
sometimes that seems not to happen.

I finally managed to nail down a reproduction, and that's this cookbook.

The default recipe includes the `repro::helper` recipe and then calls an LWRP
called `something`. The helper recipe is empty. There is a custom matcher for
this LWRP in `libraries/matchers.rb`, as expected.

To reproduce the issue, run `bundle install && bundle exec rspec`. You should
see the following output:

```
F..

Failures:

  1) failure
     Failure/Error: it { should do_something 'useful' }
     NoMethodError:
       undefined method `do_something' for #<RSpec::ExampleGroups::Failure:0x007fb8a2aff3b8>
     # ./spec/recipes/repro_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.09859 seconds (files took 0.79954 seconds to load)
3 examples, 1 failure

Failed examples:

rspec ./spec/recipes/repro_spec.rb:6 # failure
```

If you look at the spec, you'll see that the "success" group includes the line:

    `it { should include_recipe 'repro::helper' }`

....while the "failure" group does not. They are otherwise identical. This has
been reported as [chefspec#595](https://github.com/sethvargo/chefspec/issues/595).

[chefspec]: https://github.com/sethvargo/chefspec
