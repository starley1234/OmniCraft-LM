$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: V-groove pulley R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 30;               // rim radius
rim_t = 12;               // rim width
groove_r = 13;            // groove root radius
groove_w = 3;             // groove half width
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
groove_d = 2 * groove_r;

profile = [[5, 0], [30, 0], [30, 3], [13, 6], [30, 9], [30, 12], [5, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
