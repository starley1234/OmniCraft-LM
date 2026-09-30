$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 8 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[51.054, 23.919], [55.335, 38.053], [58.051, 39.997], [47.646, 42.703], [39.264, 54.863], [39.437, 58.198], [30.834, 51.75], [16.101, 52.778], [13.602, 54.993], [13.28, 44.246], [3.29, 33.369], [0, 32.796], [8.201, 25.844], [10.476, 11.251], [8.873, 8.322], [19.422, 10.399], [32.25, 3.08], [33.54, 0], [38.494, 9.542], [52.214, 15.008], [55.426, 14.097]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
