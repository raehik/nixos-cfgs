# General zram swap configuration. Not tuned very thoughtfully.

{

  # configure zram blocks for swap use
  # decent-seeming guide: https://unix.stackexchange.com/q/594817
  # apparently want ~(expected compression ratio)x RAM for max swap, but many
  # just say 1.5x
  # lz4: ~2.5x compression, fast
  # zstd: ~3x compression, slow
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 150;
  };

  # recommended settings from https://wiki.archlinux.org/title/Zram
  # we want high swappiness because our swap is on our RAM!
  # 150-200 seems recommended.
  # other settings idk but Fedora ppl discussed em.
  boot.kernel.sysctl = {
    "vm.swappiness" = 200;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

}
