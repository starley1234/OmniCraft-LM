$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: GT2 24T, pitch 2 mm, 15.03 mm x 21 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
belt_pitch = 2;           // belt pitch
n_teeth = 24;             // number of grooves
rim_w = 11;               // belt width between the flanges
tip_d = 15.03;            // tip circle diameter
root_d = 13.53;           // groove bottom diameter
groove_h = 0.75;          // groove depth
tooth_w = 1.5;            // groove width at the tip circle
shaft_d = 5.04;           // shaft bore
hub_d = 12;               // hub diameter
hub_h = 10;               // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 21;               // highest point of the pulley
set_d = 3.4;              // set screw tap hole

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
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
}
