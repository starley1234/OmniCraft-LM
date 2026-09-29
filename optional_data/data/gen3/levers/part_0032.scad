$fn = 32;

// ----------------------------------------------------------------------
// Lever: 85 mm between the bosses, 6 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 85;             // distance between the boss centres
boss_a = 19.7;            // first boss diameter
boss_b = 18;              // second boss diameter
bore_a = 12.7;            // first bore
bore_b = 4.05;            // second bore
lever_t = 6;              // lever thickness
boss_c = 26;              // middle boss diameter
bend = 6.8;               // how far the middle boss drops
slot_w = 5.4;             // adjustment slot width

lever_profile = [[-52.35, 0], [-52.229, -1.541], [-51.868, -3.044], [-51.276, -4.472], [-50.469, -5.79], [-49.465, -6.965], [-48.29, -7.969], [-46.972, -8.776], [-45.544, -9.368], [-44.041, -9.729], [-2.034, -19.64], [0, -19.8], [2.034, -19.64], [4.017, -19.164], [45.281, -8.56], [46.586, -8.019], [47.79, -7.281], [48.864, -6.364], [49.781, -5.29], [50.519, -4.086], [51.06, -2.781], [51.389, -1.408], [51.5, 0], [51.389, 1.408], [51.06, 2.781], [50.519, 4.086], [49.781, 5.29], [48.864, 6.364], [47.79, 7.281], [46.586, 8.019], [45.281, 8.56], [43.908, 8.889], [42.5, 9], [-42.5, 9.85], [-44.041, 9.729], [-45.544, 9.368], [-46.972, 8.776], [-48.29, 7.969], [-49.465, 6.965], [-50.469, 5.79], [-51.276, 4.472], [-51.868, 3.044], [-52.229, 1.541]];

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
