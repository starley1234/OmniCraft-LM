$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: GT3 30T, pitch 3 mm, 30.3 mm x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch_mm = 3;             // belt pitch
tooth_count = 30;         // number of grooves
width = 9;                // belt width between the flanges
tip_d = 28.3;             // tip circle diameter
root_d = 26.1;            // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 2.1;            // groove width at the tip circle
side_d = 30.3;            // flange diameter
side_t = 1.5;             // flange thickness
spigot_d = 24.5;          // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
hub_bore = 5.94;          // shaft bore
hub_d = 14.15;            // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = -1.5;          // lowest point of the pulley
top_z = 16.5;             // highest point of the pulley
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
}
