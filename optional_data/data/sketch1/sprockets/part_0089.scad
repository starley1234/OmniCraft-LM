$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[63.658, 27.836], [68.76, 40.938], [59.71, 50.455], [54.053, 63.328], [40.924, 63.658], [27.822, 68.76], [18.305, 59.71], [5.432, 54.053], [5.103, 40.924], [0, 27.822], [9.05, 18.305], [14.707, 5.432], [27.836, 5.103], [40.938, 0], [50.455, 9.05], [63.328, 14.707]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
