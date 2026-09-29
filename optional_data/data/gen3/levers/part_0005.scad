$fn = 32;

// ----------------------------------------------------------------------
// Lever: 100 mm between the bosses, 8 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 100;            // distance between the boss centres
boss_a = 18;              // first boss diameter
boss_b = 14;              // second boss diameter
bore_a = 9.53;            // first bore
bore_b = 2.8;             // second bore
lever_t = 8;              // lever thickness
boss_c = 22;              // middle boss diameter
bend = 16;                // how far the middle boss drops
slot_w = 5.4;             // adjustment slot width

lever_profile = [[-59, 0], [-58.889, -1.408], [-58.56, -2.781], [-58.019, -4.086], [-57.281, -5.29], [-56.364, -6.364], [-55.29, -7.281], [-54.086, -8.019], [-52.781, -8.56], [-3.399, -26.462], [-1.721, -26.865], [0, -27], [1.721, -26.865], [3.399, -26.462], [52.163, -6.657], [53.178, -6.237], [54.114, -5.663], [54.95, -4.95], [55.663, -4.114], [56.237, -3.178], [56.657, -2.163], [56.914, -1.095], [57, 0], [56.914, 1.095], [56.657, 2.163], [56.237, 3.178], [55.663, 4.114], [54.95, 4.95], [54.114, 5.663], [53.178, 6.237], [52.163, 6.657], [51.095, 6.914], [50, 7], [-50, 9], [-51.408, 8.889], [-52.781, 8.56], [-54.086, 8.019], [-55.29, 7.281], [-56.364, 6.364], [-57.281, 5.29], [-58.019, 4.086], [-58.56, 2.781], [-58.889, 1.408]];

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
