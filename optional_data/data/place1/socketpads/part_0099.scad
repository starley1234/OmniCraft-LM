$fn = 32;

// ----------------------------------------------------------------------
// Socket pad plate
// bosses with counterbored sockets for the screws
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_t = 12;             // base plate thickness
boss_h = 15;             // boss height above the base plate
boss_d = 32;             // boss diameter
socket_d = 26;           // socket diameter
socket_depth = 12;       // socket depth from the boss face
bolt_d = 9.1;            // screw clearance hole through the socket floor
plate = [160, 110, 12];  // overall size (x, y, z)
edge = 19;               // boss centre offset from the plate edge
pads = 4;                // boss count, one per corner

// --- derived feature positions (mm) ---
height = base_t + boss_h;        // = 27   overall height of the part
corner_x = plate[0] / 2 - edge;  // = 61   boss centre X
corner_y = plate[1] / 2 - edge;  // = 36   boss centre Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y],
  [corner_x, -corner_y]
];   // boss centres: sockets, holes and the pads themselves are placed from here

// base plate, bosses on feature_centers, socket + through hole in each
difference() {
  union() {
    cube(plate, center = true);
    for (centre = feature_centers)
      translate([centre[0], centre[1], plate[2] / 2 - 1])
        cylinder(d = boss_d, h = boss_h + 1);
  }
  for (centre = feature_centers) {
    translate([centre[0], centre[1], plate[2] / 2 + boss_h - socket_depth])
      cylinder(d = socket_d, h = socket_depth + 1);
    translate([centre[0], centre[1], -height])
      cylinder(d = bolt_d, h = 2 * height + 2);  // through the socket floor
  }
}
