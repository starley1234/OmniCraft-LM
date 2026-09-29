$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: T5 14T, pitch 5 mm, 21.78 mm x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
belt_pitch = 5;           // belt pitch
n_teeth = 14;             // number of grooves
rim_w = 10;               // belt width between the flanges
tip_d = 21.78;            // tip circle diameter
root_d = 19.18;           // groove bottom diameter
groove_h = 1.3;           // groove depth
tooth_w = 3;              // groove width at the tip circle
shaft_d = 5.04;           // shaft bore
hub_d = 12;               // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 16;               // highest point of the pulley

module rim() {
  cylinder(h = rim_w, d = tip_d);
}

module groove_cutter() {
  /* belt tooth groove: deeper than wide, cut through the belt width */
  translate([root_d / 2, 0, 0])
    linear_extrude(height = rim_w)
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
  for (i = [0 : n_teeth - 1]) rotate([0, 0, i * 360 / n_teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = shaft_d);
}
