$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: HTD5 24T, pitch 5 mm, 37.6 mm x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch = 5;                // belt pitch
teeth = 24;               // number of grooves
belt_w = 6;               // belt width between the flanges
tip_d = 37.6;             // tip circle diameter
root_d = 35.4;            // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 3.2;            // groove width at the tip circle
bore_d = 7.9;             // shaft bore
hub_d = 18.8;             // hub diameter
hub_h = 10;               // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 16;               // highest point of the pulley
ring_d = 2.8;             // clamp screw hole
ring_r = 12.6;            // clamp screw radius

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
  for (i = [0 : 5]) rotate([0, 0, i * 60]) translate([ring_r, 0, top_z - hub_h - 1])
    cylinder(h = hub_h + 2, d = ring_d);
}
