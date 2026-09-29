$fn = 32;

// ----------------------------------------------------------------------
// Lever: 85 mm between the bosses, 8 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 85;             // distance between the boss centres
boss_a = 20;              // first boss diameter
boss_b = 14;              // second boss diameter
bore_a = 12.7;            // first bore
bore_b = 2.8;             // second bore
lever_t = 8;              // lever thickness
boss_c = 26;              // middle boss diameter
bend = 10.2;              // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-52.5, 0], [-52.377, -1.564], [-52.011, -3.09], [-51.41, -4.54], [-50.59, -5.878], [-49.571, -7.071], [-48.378, -8.09], [-47.04, -8.91], [-45.59, -9.511], [-4.017, -22.564], [-2.034, -23.04], [0, -23.2], [2.034, -23.04], [4.017, -22.564], [44.663, -6.657], [45.678, -6.237], [46.614, -5.663], [47.45, -4.95], [48.163, -4.114], [48.737, -3.178], [49.157, -2.163], [49.414, -1.095], [49.5, 0], [49.414, 1.095], [49.157, 2.163], [48.737, 3.178], [48.163, 4.114], [47.45, 4.95], [46.614, 5.663], [45.678, 6.237], [44.663, 6.657], [43.595, 6.914], [42.5, 7], [-42.5, 10], [-44.064, 9.877], [-45.59, 9.511], [-47.04, 8.91], [-48.378, 8.09], [-49.571, 7.071], [-50.59, 5.878], [-51.41, 4.54], [-52.011, 3.09], [-52.377, 1.564]];

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
