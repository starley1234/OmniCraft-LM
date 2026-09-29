$fn = 32;

// ----------------------------------------------------------------------
// Lever: 115 mm between the bosses, 8 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 115;            // distance between the boss centres
boss_a = 18;              // first boss diameter
boss_b = 16;              // second boss diameter
bore_a = 9.53;            // first bore
bore_b = 3.6;             // second bore
lever_t = 8;              // lever thickness
boss_c = 22;              // middle boss diameter
bend = 18.4;              // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-66.5, 0], [-66.389, -1.408], [-66.06, -2.781], [-65.519, -4.086], [-64.781, -5.29], [-63.864, -6.364], [-62.79, -7.281], [-61.586, -8.019], [-60.281, -8.56], [-3.399, -28.862], [-1.721, -29.265], [0, -29.4], [1.721, -29.265], [3.399, -28.862], [59.972, -7.608], [61.132, -7.128], [62.202, -6.472], [63.157, -5.657], [63.972, -4.702], [64.628, -3.632], [65.108, -2.472], [65.402, -1.251], [65.5, 0], [65.402, 1.251], [65.108, 2.472], [64.628, 3.632], [63.972, 4.702], [63.157, 5.657], [62.202, 6.472], [61.132, 7.128], [59.972, 7.608], [58.751, 7.902], [57.5, 8], [-57.5, 9], [-58.908, 8.889], [-60.281, 8.56], [-61.586, 8.019], [-62.79, 7.281], [-63.864, 6.364], [-64.781, 5.29], [-65.519, 4.086], [-66.06, 2.781], [-66.389, 1.408]];

difference() {
  linear_extrude(height = lever_t) polygon(lever_profile);
  translate([-57.5, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_a);
  translate([57.5, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_b);
  /* slotted adjustment, stadium shaped */
  hull() {
    translate([-13.8, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
    translate([13.8, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
  }
}
