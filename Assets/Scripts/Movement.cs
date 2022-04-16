using UnityEngine;

public class Movement : MonoBehaviour
{

    Rigidbody rb;
    AudioSource audioSource;

    [SerializeField] private float angularSpeed = 10f;
    [SerializeField] private float thrust = 4f;
    [SerializeField] private AudioClip thrustClip;

    [SerializeField] private ParticleSystem mainThrustParticles;
    [SerializeField] private ParticleSystem thruster1Particles;
    [SerializeField] private ParticleSystem thruster2Particles;
    [SerializeField] private ParticleSystem thruster3Particles;
    [SerializeField] private ParticleSystem thruster4Particles;

    bool gamePaused = false;


    void Start()
    {
        rb = GetComponent<Rigidbody>();
        audioSource = GetComponent<AudioSource>();
    }


    void Update()
    {
        ProcessRotation();
        ProcessThrust();

        // toggle pause game when spacebar is pressed
        if (Input.GetKeyDown(KeyCode.P))
        {

            if (gamePaused)
            {
                Time.timeScale = 1;
                gamePaused = false;
            }
            else
            {
                Time.timeScale = 0;
                gamePaused = true;
            }

            
        }
        
        
    }

    private void ProcessThrust()
    {
        if (Input.GetKey(KeyCode.Space))
        {
            startThrusting();
        }
        else
        {
            stopThrusting();
        }
    }

    private void startThrusting()
    {
        rb.AddRelativeForce(Vector3.up * thrust * Time.deltaTime);

        if (!audioSource.isPlaying)
        {
            audioSource.PlayOneShot(thrustClip);
        }

        if (!mainThrustParticles.isPlaying)
        {
            playMainThrustParticles();
        }
    }

    private void stopThrusting()
    {
        audioSource.Stop();
        stopMainThrustParticles();
    }

    private void playMainThrustParticles()
    {
        mainThrustParticles.Play();
    }

    private void stopMainThrustParticles()
    {
        mainThrustParticles.Stop();
    }

    private void ProcessRotation()
    {
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            ApplyRotation(1);
            handleLeftThrusters();
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            ApplyRotation(-1);
            handleRightThrusters();
        }

    }

    private void ApplyRotation(float direction)
    {
        rb.freezeRotation = true;
        transform.Rotate(Vector3.forward * Time.deltaTime * angularSpeed * direction);
        rb.freezeRotation = false;
    }

    private void handleLeftThrusters()
    {

        if (!thruster1Particles.isPlaying)
        {
            thruster1Particles.Play();
            thruster2Particles.Play();
        }

        thruster3Particles.Stop();
        thruster4Particles.Stop();
    }

    private void handleRightThrusters()
    {
        if (!thruster3Particles.isPlaying)
        {
            thruster3Particles.Play();
            thruster4Particles.Play();
        }

        thruster1Particles.Stop();
        thruster2Particles.Stop();
    }
}
