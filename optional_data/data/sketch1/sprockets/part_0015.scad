$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[39.347, 17.854], [43.561, 24.88], [36.978, 31.425], [34.99, 39.374], [25.707, 39.347], [18.681, 43.561], [12.136, 36.978], [4.187, 34.99], [4.214, 25.707], [0, 18.681], [6.583, 12.136], [8.571, 4.187], [17.854, 4.214], [24.88, 0], [31.425, 6.583], [39.374, 8.571]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
