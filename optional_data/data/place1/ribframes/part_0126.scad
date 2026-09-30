$fn = 32;

// ----------------------------------------------------------------------
// Rib frame 120 x 60 x 15
// 5 ribs at 20 mm pitch
// ----------------------------------------------------------------------

// --- parameters (mm) ---
frame = [120, 60, 5];  // base plate size (x, y, z)
rail_w = 6;            // side rail width
ribs = 5;              // number of ribs
rib_t = 6;             // rib thickness
rib_h = 10;            // rib height above the base plate
pitch = 20;            // pitch between rib centres

// --- derived feature positions (mm) ---
span = (ribs - 1) * pitch;          // = 80   distance between the outer ribs
origin_x = -span / 2;               // = -40   X of the first rib
rib_len = frame[1] - 2 * rail_w + 2;  // = 50   rib length, 1 mm into each rail
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
