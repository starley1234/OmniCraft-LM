$fn = 32;

// ----------------------------------------------------------------------
// Lever: 85 mm between the bosses, 6 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 85;             // distance between the boss centres
boss_a = 24;              // first boss diameter
boss_b = 18;              // second boss diameter
bore_a = 7.94;            // first bore
bore_b = 4.05;            // second bore
lever_t = 6;              // lever thickness
boss_c = 26;              // middle boss diameter
bend = 13.6;              // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-54.5, 0], [-54.352, -1.877], [-53.913, -3.708], [-53.192, -5.448], [-52.208, -7.053], [-50.985, -8.485], [-49.553, -9.708], [-47.948, -10.692], [-46.208, -11.413], [-4.017, -25.964], [-2.034, -26.44], [0, -26.6], [2.034, -26.44], [4.017, -25.964], [5.902, -25.183], [46.586, -8.019], [47.79, -7.281], [48.864, -6.364], [49.781, -5.29], [50.519, -4.086], [51.06, -2.781], [51.389, -1.408], [51.5, 0], [51.389, 1.408], [51.06, 2.781], [50.519, 4.086], [49.781, 5.29], [48.864, 6.364], [47.79, 7.281], [46.586, 8.019], [45.281, 8.56], [43.908, 8.889], [42.5, 9], [-42.5, 12], [-44.377, 11.852], [-46.208, 11.413], [-47.948, 10.692], [-49.553, 9.708], [-50.985, 8.485], [-52.208, 7.053], [-53.192, 5.448], [-53.913, 3.708], [-54.352, 1.877]];

difference() {
  linear_extrude(height = lever_t) polygon(lever_profile);
  translate([-42.5, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_a);
  translate([42.5, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_b);
  /* slotted adjustment, stadium shaped */
  hull() {
    translate([-10.2, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
    translate([10.2, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
  }
}
