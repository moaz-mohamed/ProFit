import cv2
import mediapipe as mp
import numpy as np

mp_drawing = mp.solutions.drawing_utils
mp_pose = mp.solutions.pose


class Workout:

    def calculate_angle(self, a, b, c):
        a = np.array(a)  # First
        b = np.array(b)  # Mid
        c = np.array(c)  # End
        radians = np.arctan2(c[1] - b[1], c[0] - b[0]) - np.arctan2(a[1] - b[1], a[0] - b[0])
        angle = np.abs(radians * 180.0 / np.pi)
        if angle > 180.0:
            angle = 360 - angle
        return angle

    def workout_detection(self, number, video):
        counter_for_biceps = 0  # for biceps counter
        counter_for_shoulders = 0  # for shoulders
        counter_for_squat = 0
        # exercise number (0 for biceps ,1 for shoulder,2 for squat)
        up = False  # For shoulder hand stage
        stage_squat = None  # For squat stage
        stage_biceps = None

        if number == 1:
            cap = cv2.VideoCapture(video)
            with mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5) as pose:
                while cap.isOpened():
                    ret, frame = cap.read()
                    if not ret:
                        break
                    # Recolor image to RGB
                    image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                    image.flags.writeable = False

                    # Make detection
                    results = pose.process(image)

                    # Recolor back to BGR
                    image.flags.writeable = True
                    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

                    # Extract landmarks
                    try:
                        landmarks = results.pose_landmarks.landmark
                        # Get coordinates for Right arm            
                        shoulder_right = [landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].x,
                                          landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].y]
                        elbow_right = [landmarks[mp_pose.PoseLandmark.RIGHT_ELBOW.value].x,
                                       landmarks[mp_pose.PoseLandmark.RIGHT_ELBOW.value].y]
                        wrist_right = [landmarks[mp_pose.PoseLandmark.RIGHT_WRIST.value].x,
                                       landmarks[mp_pose.PoseLandmark.RIGHT_WRIST.value].y]
                        # Calculate angle

                        angle_for_right_arm = self.calculate_angle(shoulder_right, elbow_right, wrist_right)

                        if angle_for_right_arm > 160:
                            stage_biceps = "down"
                        if angle_for_right_arm < 30 and stage_biceps == 'down':
                            stage_biceps = "up"
                            counter_for_biceps += 1

                    except:
                        pass
                    calories_burnt = counter_for_biceps * 0.2
                cap.release()
                return counter_for_biceps

        elif number == 2:
            cap = cv2.VideoCapture(video)
            with mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5) as pose:
                while cap.isOpened():
                    ret, frame = cap.read()
                    if not ret:
                        break
                    # Recolor image to RGB
                    image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                    image.flags.writeable = False

                    # Make detection
                    results = pose.process(image)

                    # Recolor back to BGR
                    image.flags.writeable = True
                    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
                    if results.pose_landmarks:
                        points = {}
                        for id, lm in enumerate(results.pose_landmarks.landmark):
                            h, w, c = image.shape
                            cx, cy = int(lm.x * w), int(lm.y * h)
                            points[id] = (cx, cy)
                        if not up and points[14][1] + 40 < points[12][1]:
                            up = True
                            counter_for_shoulders += 1

                        elif points[14][1] > points[12][1]:
                            up = False

                        calories_burnt_shoulders = counter_for_shoulders * 0.1875
                cap.release()
                return counter_for_shoulders

        elif number == 3:
            cap = cv2.VideoCapture(video)
            with mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5) as pose:
                while cap.isOpened():
                    ret, frame = cap.read()
                    if not ret:
                        break
                    # Recolor image to RGB
                    image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                    image.flags.writeable = False

                    # Make detection
                    results = pose.process(image)

                    # Recolor back to BGR
                    image.flags.writeable = True
                    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

                    # Extract landmarks
                    try:
                        landmarks = results.pose_landmarks.landmark

                        # Get coordinates for squat
                        hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].x,
                               landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].y]
                        knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].x,
                                landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].y]
                        ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].x,
                                 landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].y]
                        shoulder = [landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].x,
                                    landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].y]

                        angle_knee = self.calculate_angle(hip, knee, ankle)  # Knee joint angle

                        angle_hip = self.calculate_angle(shoulder, hip, knee)
                        hip_angle = 180 - angle_hip
                        knee_angle = 180 - angle_knee

                        # Curl counter logic
                        if angle_knee > 150:
                            stage_squat = "UP"
                        if angle_knee <= 90 and stage_squat == 'UP':
                            stage_squat = "DOWN"
                            counter_for_squat += 1

                    except:
                        pass

                    calories_burnt_squat = counter_for_squat * 0.32
            cap.release()
            calories_burnt_squat = counter_for_squat * 0.32
            return counter_for_squat
