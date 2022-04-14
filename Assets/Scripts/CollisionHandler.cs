using UnityEngine;
using UnityEngine.SceneManagement;

public class CollisionHandler : MonoBehaviour
{

    [SerializeField] private AudioClip deathClip;
    [SerializeField] private AudioClip finishClip;
    [SerializeField] private ParticleSystem successParticles;
    [SerializeField] private ParticleSystem crashParticles;

    private AudioSource audioSource;

    bool inLoop = false;

    void Start()
    {
        audioSource = GetComponent<AudioSource>();
    }

    private void OnCollisionEnter(Collision other)
    {

        if (inLoop) { return; }

        switch (other.gameObject.tag)
        {
            case "Finish":
                StartSuccessSequence();
                break;

            case "Friendly":
                break;

            default:
                StartCrashSequence();
                break;
        }

    }

    private void StartSuccessSequence()
    {
        inLoop = true;
        audioSource.PlayOneShot(finishClip);
        successParticles.Play();
        gameObject.GetComponent<Movement>().enabled = false;
        Invoke("LoadNextLevel", 3f);
    }

    private void StartCrashSequence()
    {
        inLoop = true;
        audioSource.PlayOneShot(deathClip);
        crashParticles.Play();
        gameObject.GetComponent<Movement>().enabled = false;
        Invoke("ReloadLevel", 2f);
    }

    private void LoadNextLevel()
    {

        // get total number of scenes
        int totalScenes = SceneManager.sceneCountInBuildSettings;

        // if current scene is last scene, load first scene
        int currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
        if (currentSceneIndex == totalScenes - 1)
        {
            SceneManager.LoadScene(0);
        }
        else
        {
            // load next scene
            SceneManager.LoadScene(currentSceneIndex + 1);
        }

    }


    private void ReloadLevel()
    {
        string currentSceneName = SceneManager.GetActiveScene().name;
        SceneManager.LoadScene(currentSceneName);
    }
}
