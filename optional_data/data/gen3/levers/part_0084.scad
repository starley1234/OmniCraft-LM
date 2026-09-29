$fn = 32;

// ----------------------------------------------------------------------
// Lever: 100 mm between the bosses, 6 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 100;            // distance between the boss centres
boss_a = 20;              // first boss diameter
boss_b = 14;              // second boss diameter
bore_a = 9.53;            // first bore
bore_b = 3.15;            // second bore
lever_t = 6;              // lever thickness
boss_c = 22;              // middle boss diameter
bend = 16;                // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-60, 0], [-59.877, -1.564], [-59.511, -3.09], [-58.91, -4.54], [-58.09, -5.878], [-57.071, -7.071], [-55.878, -8.09], [-54.54, -8.91], [-53.09, -9.511], [-3.399, -26.462], [-1.721, -26.865], [0, -27], [1.721, -26.865], [3.399, -26.462], [52.163, -6.657], [53.178, -6.237], [54.114, -5.663], [54.95, -4.95], [55.663, -4.114], [56.237, -3.178], [56.657, -2.163], [56.914, -1.095], [57, 0], [56.914, 1.095], [56.657, 2.163], [56.237, 3.178], [55.663, 4.114], [54.95, 4.95], [54.114, 5.663], [53.178, 6.237], [52.163, 6.657], [51.095, 6.914], [50, 7], [-50, 10], [-51.564, 9.877], [-53.09, 9.511], [-54.54, 8.91], [-55.878, 8.09], [-57.071, 7.071], [-58.09, 5.878], [-58.91, 4.54], [-59.511, 3.09], [-59.877, 1.564]];

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
