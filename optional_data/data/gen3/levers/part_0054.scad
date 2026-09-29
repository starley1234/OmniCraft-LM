$fn = 32;

// ----------------------------------------------------------------------
// Lever: 115 mm between the bosses, 10 mm thick, smooth outline
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lever_l = 115;            // distance between the boss centres
boss_a = 24;              // first boss diameter
boss_b = 14;              // second boss diameter
bore_a = 7.94;            // first bore
bore_b = 2.8;             // second bore
lever_t = 10;             // lever thickness
boss_c = 26;              // middle boss diameter
bend = 13.8;              // how far the middle boss drops
slot_w = 6.6;             // adjustment slot width

lever_profile = [[-69.5, 0], [-69.352, -1.877], [-68.913, -3.708], [-68.192, -5.448], [-67.208, -7.053], [-65.985, -8.485], [-64.553, -9.708], [-62.948, -10.692], [-61.208, -11.413], [-4.017, -26.164], [-2.034, -26.64], [0, -26.8], [2.034, -26.64], [4.017, -26.164], [59.663, -6.657], [60.678, -6.237], [61.614, -5.663], [62.45, -4.95], [63.163, -4.114], [63.737, -3.178], [64.157, -2.163], [64.414, -1.095], [64.5, 0], [64.414, 1.095], [64.157, 2.163], [63.737, 3.178], [63.163, 4.114], [62.45, 4.95], [61.614, 5.663], [60.678, 6.237], [59.663, 6.657], [58.595, 6.914], [57.5, 7], [-57.5, 12], [-59.377, 11.852], [-61.208, 11.413], [-62.948, 10.692], [-64.553, 9.708], [-65.985, 8.485], [-67.208, 7.053], [-68.192, 5.448], [-68.913, 3.708], [-69.352, 1.877]];

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
