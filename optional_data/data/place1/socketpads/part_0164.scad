$fn = 32;

// ----------------------------------------------------------------------
// Socket pad plate
// bosses with counterbored sockets for the screws
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_t = 10;       // base plate thickness
boss_h = 8;        // boss height above the base plate
boss_d = 32;       // boss diameter
socket_d = 24;     // socket diameter
socket_depth = 6;  // socket depth from the boss face
bolt_d = 8.4;      // screw clearance hole through the socket floor
rows = 2;          // boss rows
cols = 3;          // bosses per row
pitch = 40;        // boss pitch

// --- derived feature positions (mm) ---
height = base_t + boss_h;           // = 18   overall height of the part
plate = [pitch * (cols - 1) + boss_d + 8, pitch * (rows - 1) + boss_d + 8, base_t];  // = [120, 80, 10]   overall size (x, y, z)
span_x = pitch * (cols - 1);        // = 80   distance between outer bosses
span_y = pitch * (rows - 1);        // = 40   distance between boss rows
origin_x = -span_x / 2;             // = -40   X of the first boss
origin_y = -span_y / 2;             // = -20   Y of the first boss
feature_centers = [
  [origin_x + 0 * pitch, origin_y + 0 * pitch],
  [origin_x + 1 * pitch, origin_y + 0 * pitch],
  [origin_x + 2 * pitch, origin_y + 0 * pitch],
  [origin_x + 0 * pitch, origin_y + 1 * pitch],
  [origin_x + 1 * pitch, origin_y + 1 * pitch],
  [origin_x + 2 * pitch, origin_y + 1 * pitch]
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
