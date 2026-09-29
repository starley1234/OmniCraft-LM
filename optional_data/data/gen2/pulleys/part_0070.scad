$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: T5 16T, pitch 5 mm, 27.96 mm x 21.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch = 5;                // belt pitch
teeth = 16;               // number of grooves
belt_w = 11;              // belt width between the flanges
tip_d = 24.96;            // tip circle diameter
root_d = 22.36;           // groove bottom diameter
groove_h = 1.3;           // groove depth
tooth_w = 3;              // groove width at the tip circle
flange_d = 27.96;         // flange diameter
flange_t = 1.2;           // flange thickness
spigot_d = 20.76;         // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
bore_d = 5.24;            // shaft bore
hub_d = 12.48;            // hub diameter
hub_h = 8;                // hub above the flange
bottom_z = -1.2;          // lowest point of the pulley
top_z = 20.2;             // highest point of the pulley
set_d = 3.4;              // set screw tap hole

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

module flanges() {
  translate([0, 0, -flange_t]) cylinder(h = flange_t, d = flange_d);
  translate([0, 0, belt_w]) cylinder(h = flange_t, d = flange_d);
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 0.6, d = spigot_d);
  translate([0, 0, belt_w - 0.6]) cylinder(h = spigot_h + 0.6, d = spigot_d);
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
  for (i = [0 : teeth - 1]) rotate([0, 0, i * 360 / teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = bore_d);
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
}
