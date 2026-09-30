$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 14 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[56.955, 29.945], [64.66, 45.192], [69.801, 47.476], [53.546, 48.729], [46.43, 64.26], [47.849, 69.703], [36.735, 57.776], [20.156, 61.895], [16.785, 66.399], [19.18, 50.273], [5.623, 39.879], [0, 40.052], [14.101, 31.87], [13.775, 14.79], [10.134, 10.501], [25.323, 16.425], [38.473, 5.52], [39.555, 0], [44.394, 15.568], [61.119, 19.051], [66.11, 16.455]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
