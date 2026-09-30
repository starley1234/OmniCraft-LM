$fn = 32;

// ----------------------------------------------------------------------
// Rib frame 220 x 100 x 29
// 5 ribs at 20 mm pitch
// ----------------------------------------------------------------------

// --- parameters (mm) ---
frame = [220, 100, 4];  // base plate size (x, y, z)
seat_tol = 0.1;         // tolerance at the seating features
free_tol = 0.3;         // general tolerance on the free sizes
rail_w = 8;             // side rail width
ribs = 5;               // number of ribs
rib_t = 4;              // rib thickness
rib_h = 25;             // rib height above the base plate
pitch = 20;             // pitch between rib centres

// --- derived feature positions (mm) ---
span = (ribs - 1) * pitch;          // = 80   distance between the outer ribs
origin_x = -span / 2;               // = -40   X of the first rib
rib_len = frame[1] - 2 * rail_w + 2;  // = 86   rib length, 1 mm into each rail
feature_centers = [
  [origin_x + 0 * pitch, 0],
  [origin_x + 1 * pitch, 0],
  [origin_x + 2 * pitch, 0],
  [origin_x + 3 * pitch, 0],
  [origin_x + 4 * pitch, 0]
];   // rib centre line, drives the rib loop

// base plate, two side rails, then the ribs read straight off feature_centers
union() {
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube(frame);
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  translate([-frame[0] / 2, frame[1] / 2 - rail_w, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  for (centre = feature_centers)
    translate([centre[0] - rib_t / 2, centre[1] - rib_len / 2, frame[2] - 1])
      cube([rib_t, rib_len, rib_h + 1]);
}
