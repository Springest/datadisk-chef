This project is **no longer maintained**.

If you're interested in taking it over, we'd love to hear from you.
Email [developers@springest.com](mailto:developers@springest.com), or check out
one of its maintained forks.

*****

datadisk Cookbook
=================

This cookbook formats and mounts a second disk (datadisk) on the specified mountpoint. If you like living dangerously, you can try this with an existing dir by using ::existing_datadir, but that code is less polished (this is done in single user mode using rsync, which is somewhat finicky).

Requirements
------------
- a second disk following the format of /dev/[sx]v?d[a-z], e.g. /dev/sdb or /dev/xvde, containing a partition without filesystem

for the ::existing_datadir recipe:
- an OS using upstart
- recent, working (believe is what you do in church!) backups (though tested and with several failsafes in place, this cookbook still does pretty scary stuff.)

Attributes
----------
#### datadisk::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['datadisk']['datapart']</tt></td>
    <td>string</td>
    <td>the target mountpoint e.g. /data or /opt</td>
    <td><tt>/data</tt></td>
  </tr>
  <tr>
    <td><tt>['datadisk']['doitlive']</tt></td>
    <td>Boolean</td>
    <td>Only for ::existing_datadir: whether to reboot immediately after the chef run</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### datadisk::default

Just include `datadisk` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[datadisk]"
  ]
}
```

#### datadisk::existing_datadir

Just include `datadisk::existing_datadir` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[datadisk::existing_datadir]"
  ]
}
```
After the chef run, schedule a reboot on your desired point in time. Since the entire contents of 'datapart' needs to be rsync'd, downtime can be considerable.

Contributing
------------

e.g.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`) 
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Milo de Vries
