$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: HTD5 20T, pitch 5 mm, 31.23 mm x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch_mm = 5;             // belt pitch
tooth_count = 20;         // number of grooves
width = 16;               // belt width between the flanges
tip_d = 31.23;            // tip circle diameter
root_d = 29.03;           // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 3.2;            // groove width at the tip circle
hub_bore = 6.56;          // shaft bore
hub_d = 15.62;            // hub diameter
hub_h = 4;                // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 20;               // highest point of the pulley
set_d = 3.4;              // set screw tap hole

module rim() {
  cylinder(h = width, d = tip_d);
}

module groove_cutter() {
  /* belt tooth groove: deeper than wide, cut through the belt width */
  translate([root_d / 2, 0, 0])
    linear_extrude(height = width)
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
  for (i = [0 : tooth_count - 1]) rotate([0, 0, i * 360 / tooth_count]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = hub_bore);
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
}
