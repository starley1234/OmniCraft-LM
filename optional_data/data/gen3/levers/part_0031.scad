$fn = 32;

// ----------------------------------------------------------------------
// Lever: 70 mm between the bosses, 10 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 70;             // distance between the boss centres
boss_a = 20;              // first boss diameter
boss_b = 14;              // second boss diameter
bore_a = 7.94;            // first bore
bore_b = 2.8;             // second bore
lever_t = 10;             // lever thickness
boss_c = 26;              // middle boss diameter
bend = 5.6;               // how far the middle boss drops
slot_w = 5.4;             // adjustment slot width

lever_profile = [[-45, 0], [-44.877, -1.564], [-44.511, -3.09], [-43.91, -4.54], [-43.09, -5.878], [-42.071, -7.071], [-40.878, -8.09], [-39.54, -8.91], [-38.09, -9.511], [-4.017, -17.964], [-2.034, -18.44], [0, -18.6], [2.034, -18.44], [4.017, -17.964], [37.163, -6.657], [38.178, -6.237], [39.114, -5.663], [39.95, -4.95], [40.663, -4.114], [41.237, -3.178], [41.657, -2.163], [41.914, -1.095], [42, 0], [41.914, 1.095], [41.657, 2.163], [41.237, 3.178], [40.663, 4.114], [39.95, 4.95], [39.114, 5.663], [38.178, 6.237], [37.163, 6.657], [36.095, 6.914], [35, 7], [-35, 10], [-36.564, 9.877], [-38.09, 9.511], [-39.54, 8.91], [-40.878, 8.09], [-42.071, 7.071], [-43.09, 5.878], [-43.91, 4.54], [-44.511, 3.09], [-44.877, 1.564]];

difference() {
  linear_extrude(height = lever_t) polygon(lever_profile);
  translate([-35, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_a);
  translate([35, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_b);
  /* slotted adjustment, stadium shaped */
  hull() {
    translate([-8.4, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
    translate([8.4, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);
  }
}
