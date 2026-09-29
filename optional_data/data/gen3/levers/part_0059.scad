$fn = 32;

// ----------------------------------------------------------------------
// Lever: 100 mm between the bosses, 6 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 100;            // distance between the boss centres
boss_a = 18;              // first boss diameter
boss_b = 18;              // second boss diameter
bore_a = 7.94;            // first bore
bore_b = 4.05;            // second bore
lever_t = 6;              // lever thickness
boss_c = 26;              // middle boss diameter
bend = 16;                // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-59, 0], [-58.889, -1.408], [-58.56, -2.781], [-58.019, -4.086], [-57.281, -5.29], [-56.364, -6.364], [-55.29, -7.281], [-54.086, -8.019], [-52.781, -8.56], [-4.017, -28.364], [-2.034, -28.84], [0, -29], [2.034, -28.84], [4.017, -28.364], [52.781, -8.56], [54.086, -8.019], [55.29, -7.281], [56.364, -6.364], [57.281, -5.29], [58.019, -4.086], [58.56, -2.781], [58.889, -1.408], [59, 0], [58.889, 1.408], [58.56, 2.781], [58.019, 4.086], [57.281, 5.29], [56.364, 6.364], [55.29, 7.281], [54.086, 8.019], [52.781, 8.56], [51.408, 8.889], [50, 9], [-50, 9], [-51.408, 8.889], [-52.781, 8.56], [-54.086, 8.019], [-55.29, 7.281], [-56.364, 6.364], [-57.281, 5.29], [-58.019, 4.086], [-58.56, 2.781], [-58.889, 1.408]];

difference() {
  linear_extrude(height = lever_t) polygon(lever_profile);
  translate([-50, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_a);
  translate([50, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_b);
  /* slotted adjustment, stadium shaped */
  hull() {
    translate([-12, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
    translate([12, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
  }
}
