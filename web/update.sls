/data/website/laravel:
  file.recurse:                                        
    - source: salt://storage/laravel/laravel-topka
    - clean: True
    - exclude_pat: "*.git*"
    - include_empty: True
    - user: www-data                                     
    - group: www-data                                    
    - file_mode: 644                                     
    - dir_mode: 755                                      
    - makedirs: True                                     
    #- backup: minion                                     
    - recurse:                                           
      - user                                             
      - group                                            
      - mode
