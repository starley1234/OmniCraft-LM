$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: GT2 22T, pitch 2 mm, 13.76 mm x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch = 2;                // belt pitch
teeth = 22;               // number of grooves
belt_w = 10;              // belt width between the flanges
tip_d = 13.76;            // tip circle diameter
root_d = 12.26;           // groove bottom diameter
groove_h = 0.75;          // groove depth
tooth_w = 1.5;            // groove width at the tip circle
bore_d = 4.73;            // shaft bore
hub_d = 11.26;            // hub diameter
hub_h = 10;               // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 20;               // highest point of the pulley

module rim() {
  cylinder(h = belt_w, d = tip_d);
}

module groove_cutter() {
  /* belt tooth groove: deeper than wide, cut through the belt width */
  translate([root_d / 2, 0, 0])
    linear_extrude(height = belt_w)
      polygon(points = [[-0.6, -tooth_w * 0.42], [groove_h + 0.6, -tooth_w * 0.6],
                        [groove_h + 0.6, tooth_w * 0.6], [-0.6, tooth_w * 0.42]]);
}

module hub() {
  translate([0, 0, bottom_z]) cylinder(h = top_z - bottom_z, d = hub_d);
}

difference() {
  union() {
    rim();
    hub();
  }
  for (i = [0 : teeth - 1]) rotate([0, 0, i * 360 / teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = bore_d);
}
