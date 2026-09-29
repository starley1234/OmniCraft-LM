$fn = 32;

// ----------------------------------------------------------------------
// Lever: 85 mm between the bosses, 6 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 85;             // distance between the boss centres
boss_a = 18;              // first boss diameter
boss_b = 16;              // second boss diameter
bore_a = 9.53;            // first bore
bore_b = 3.2;             // second bore
lever_t = 6;              // lever thickness
boss_c = 22;              // middle boss diameter
bend = 13.6;              // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-51.5, 0], [-51.389, -1.408], [-51.06, -2.781], [-50.519, -4.086], [-49.781, -5.29], [-48.864, -6.364], [-47.79, -7.281], [-46.586, -8.019], [-45.281, -8.56], [-3.399, -24.062], [-1.721, -24.465], [0, -24.6], [1.721, -24.465], [3.399, -24.062], [44.972, -7.608], [46.132, -7.128], [47.202, -6.472], [48.157, -5.657], [48.972, -4.702], [49.628, -3.632], [50.108, -2.472], [50.402, -1.251], [50.5, 0], [50.402, 1.251], [50.108, 2.472], [49.628, 3.632], [48.972, 4.702], [48.157, 5.657], [47.202, 6.472], [46.132, 7.128], [44.972, 7.608], [43.751, 7.902], [42.5, 8], [-42.5, 9], [-43.908, 8.889], [-45.281, 8.56], [-46.586, 8.019], [-47.79, 7.281], [-48.864, 6.364], [-49.781, 5.29], [-50.519, 4.086], [-51.06, 2.781], [-51.389, 1.408]];

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
