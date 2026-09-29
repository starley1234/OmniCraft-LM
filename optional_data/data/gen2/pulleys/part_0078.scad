$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: GT2 36T, pitch 2 mm, 24.67 mm x 13 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
belt_pitch = 2;           // belt pitch
n_teeth = 36;             // number of grooves
rim_w = 6;                // belt width between the flanges
tip_d = 22.67;            // tip circle diameter
root_d = 21.17;           // groove bottom diameter
groove_h = 0.75;          // groove depth
tooth_w = 1.5;            // groove width at the tip circle
rim_d = 24.67;            // flange diameter
rim_t = 1.5;              // flange thickness
spigot_d = 19.57;         // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
shaft_d = 5.04;           // shaft bore
hub_d = 12;               // hub diameter
hub_h = 4;                // hub above the flange
bottom_z = -1.5;          // lowest point of the pulley
top_z = 11.5;             // highest point of the pulley
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

module flanges() {
  translate([0, 0, -rim_t]) cylinder(h = rim_t, d = rim_d);
  translate([0, 0, rim_w]) cylinder(h = rim_t, d = rim_d);
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 0.6, d = spigot_d);
  translate([0, 0, rim_w - 0.6]) cylinder(h = spigot_h + 0.6, d = spigot_d);
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
  for (i = [0 : n_teeth - 1]) rotate([0, 0, i * 360 / n_teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = shaft_d);
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
}
