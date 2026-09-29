$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: HTD5 20T, pitch 5 mm, 34.23 mm x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch_mm = 5;             // belt pitch
tooth_count = 20;         // number of grooves
width = 9;                // belt width between the flanges
tip_d = 31.23;            // tip circle diameter
root_d = 29.03;           // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 3.2;            // groove width at the tip circle
side_d = 34.23;           // flange diameter
side_t = 1.5;             // flange thickness
spigot_d = 27.43;         // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
hub_bore = 6.56;          // shaft bore
hub_d = 15.62;            // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = -1.5;          // lowest point of the pulley
top_z = 16.5;             // highest point of the pulley
ring_d = 2.8;             // clamp screw hole
ring_r = 10.2;            // clamp screw radius

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

module flanges() {
  translate([0, 0, -side_t]) cylinder(h = side_t, d = side_d);
  translate([0, 0, width]) cylinder(h = side_t, d = side_d);
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 0.6, d = spigot_d);
  translate([0, 0, width - 0.6]) cylinder(h = spigot_h + 0.6, d = spigot_d);
}

module hub() {
  translate([0, 0, bottom_z]) cylinder(h = top_z - bottom_z, d = hub_d);
}

difference() {
  union() {
    rim();
    hub();
    flanges();
  }
  for (i = [0 : tooth_count - 1]) rotate([0, 0, i * 360 / tooth_count]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = hub_bore);
  for (i = [0 : 5]) rotate([0, 0, i * 60]) translate([ring_r, 0, top_z - hub_h - 1])
    cylinder(h = hub_h + 2, d = ring_d);
}
