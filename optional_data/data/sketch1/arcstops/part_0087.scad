$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[69.712, 0], [68.405, 10.645], [64.561, 20.657], [61.029, 18.779], [55.169, 27.06], [47.413, 33.601], [38.262, 37.98], [28.303, 39.916], [18.177, 39.284], [8.536, 36.125], [0, 30.642], [6.428, 22.981], [18.454, 29.109], [31.949, 29.344], [44.181, 23.64], [52.675, 13.151], [55.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
