$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: GT2 36T, pitch 2 mm, 24.67 mm x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch_mm = 2;             // belt pitch
tooth_count = 36;         // number of grooves
width = 16;               // belt width between the flanges
tip_d = 22.67;            // tip circle diameter
root_d = 21.17;           // groove bottom diameter
groove_h = 0.75;          // groove depth
tooth_w = 1.5;            // groove width at the tip circle
side_d = 24.67;           // flange diameter
side_t = 1.5;             // flange thickness
spigot_d = 19.57;         // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
hub_bore = 5.04;          // shaft bore
hub_d = 12;               // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = -1.5;          // lowest point of the pulley
top_z = 23.5;             // highest point of the pulley
set_d = 3.4;              // set screw tap hole
ring_d = 2.8;             // clamp screw hole
ring_r = 7.3;             // clamp screw radius

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
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
  for (i = [0 : 5]) rotate([0, 0, i * 60]) translate([ring_r, 0, top_z - hub_h - 1])
    cylinder(h = hub_h + 2, d = ring_d);
}
