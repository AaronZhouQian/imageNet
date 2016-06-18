__global__ void add(int *a, int *b , int *result)
{
    int index=blockIdx.x * blockDim.x + threadIdx.x;
    *result[index]= *a[index] + *b[index];   
}

#define N (2048*2048)
#define THREADS_PER_BLOCK 512

int main()
{
    int a,b,result;
    int *device_a,*device_b,*device_result;
    int size=sizeof(int)*N;
    
    cudaMalloc((void **)&device_a,size);
    cudaMalloc((void **)&device_b,size);
    cudaMalloc((void **)&device_result,size);
    
    a=(int *)malloc(size);
    b=(int *)malloc(size);
    result=(int *)malloc(size);
    
    random_ints(a,N);
    random_ints(b,N);
    
    cudaMemcpy(device_a,&a,size,cudaMemcpyHostToDevice);
    cudaMemcpy(device_b,&b,size,cudaMemcpyHostToDevice);
    
    add<<<N/THREADS_PER_BLOCK,THREADS_PER_BLOCK>>>(device_a,device_b,device_result);
    
    cudaMemcpy(&result,device_result,size,cudaMemcpyDeviceToHost);
    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_result);
    
    free(a);
    free(b);
    free(result);
    
    return 0;
}




















